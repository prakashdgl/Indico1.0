// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class HSCodeBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private string _code = string.Empty;
        private int _gender;
        private int _itemSubCategory;
        #endregion
        
        #region Foreign Key fields
        [NonSerialized][XmlIgnoreAttribute]
        private Indico.BusinessObjects.GenderBO _objGender;
        [NonSerialized][XmlIgnoreAttribute]
        private Indico.BusinessObjects.ItemBO _objItemSubCategory;
        #endregion
        
        #region Foreign Table Foreign Key fields
        #endregion
        
        #region Other fields
        
        private Indico.DAL.HSCode _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>. The maximum length of this property is 64.</summary>
        public string Code
        {   
            get {return _code;}
            set 
            {
                OnCodeChanging(value);
                _code = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Code = value;
                }
                OnCodeChanged();
            }
        }
        /// <summary>.</summary>
        public int Gender
        {   
            get {return _gender;}
            set 
            {
                OnGenderChanging(value);
                _gender = value;
                if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && ((int)value != 0))
                {
                    this.ObjDAL.Gender = (from o in this._context.Context.Gender
                                           where o.ID == (int)value
                                           select o).ToList<Indico.DAL.Gender>()[0];
                }
                else if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && (int)value == 0)
                    this.ObjDAL.Gender = null;
                OnGenderChanged();
            }
        }
        /// <summary>.</summary>
        public int ItemSubCategory
        {   
            get {return _itemSubCategory;}
            set 
            {
                OnItemSubCategoryChanging(value);
                _itemSubCategory = value;
                if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && ((int)value != 0))
                {
                    this.ObjDAL.ItemSubCategory = (from o in this._context.Context.Item
                                           where o.ID == (int)value
                                           select o).ToList<Indico.DAL.Item>()[0];
                }
                else if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && (int)value == 0)
                    this.ObjDAL.ItemSubCategory = null;
                OnItemSubCategoryChanged();
            }
        }
        
        internal Indico.DAL.HSCode ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        ///<summary>The GenderBO object identified by the value of Gender</summary>
        [XmlIgnoreAttribute]
        public Indico.BusinessObjects.GenderBO objGender
        {
            get
            {
                if ( _gender > 0 && _objGender == null)
                {
                        if (this._context == null)
                        {
                            _objGender = new Indico.BusinessObjects.GenderBO();
                        }
                        else
                        {
                            _objGender = new Indico.BusinessObjects.GenderBO(ref this._context);
                        }
                        _objGender.ID = _gender;
                        _objGender.GetObject(); 
                }
                return _objGender;
            }
            set
            { 
                _objGender = value;
                _gender = _objGender.ID;
            }
        }
        ///<summary>The ItemBO object identified by the value of ItemSubCategory</summary>
        [XmlIgnoreAttribute]
        public Indico.BusinessObjects.ItemBO objItemSubCategory
        {
            get
            {
                if ( _itemSubCategory > 0 && _objItemSubCategory == null)
                {
                        if (this._context == null)
                        {
                            _objItemSubCategory = new Indico.BusinessObjects.ItemBO();
                        }
                        else
                        {
                            _objItemSubCategory = new Indico.BusinessObjects.ItemBO(ref this._context);
                        }
                        _objItemSubCategory.ID = _itemSubCategory;
                        _objItemSubCategory.GetObject(); 
                }
                return _objItemSubCategory;
            }
            set
            { 
                _objItemSubCategory = value;
                _itemSubCategory = _objItemSubCategory.ID;
            }
        }
        #endregion
        
        #region Foreign Object Foreign Key Collections
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the HSCodeBO class using the supplied Indico.DAL.HSCode. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.HSCode whose properties will be used to initialise the HSCodeBO</param>
        internal HSCodeBO(Indico.DAL.HSCode obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.HSCode 
            this.ID = obj.ID;
            
            this.Code = obj.Code;
            this.Gender = (obj.GenderReference.EntityKey != null && obj.GenderReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.GenderReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            this.ItemSubCategory = (obj.ItemSubCategoryReference.EntityKey != null && obj.ItemSubCategoryReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.ItemSubCategoryReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.HSCode SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.HSCode properties
            Indico.DAL.HSCode obj = new Indico.DAL.HSCode();
            
            if (this.ID > 0)
            {
                obj = context.HSCode.FirstOrDefault<HSCode>(o => o.ID == this.ID);
            }
            
            obj.Code = this.Code;
            
            if (this.Gender > 0) obj.Gender = context.Gender.FirstOrDefault(o => o.ID == this.Gender);
            if (this.ItemSubCategory > 0) obj.ItemSubCategory = context.Item.FirstOrDefault(o => o.ID == this.ItemSubCategory);
            
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.HSCode))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.HSCode obj = (Indico.DAL.HSCode)eObj;
            
            // set the Indico.BusinessObjects.HSCodeBO properties
            this.ID = obj.ID;
            
            this.Code = obj.Code;
            
            this.Gender = (obj.GenderReference.EntityKey != null && obj.GenderReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.GenderReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            this.ItemSubCategory = (obj.ItemSubCategoryReference.EntityKey != null && obj.ItemSubCategoryReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.ItemSubCategoryReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.HSCodeBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.HSCodeBO properties
            this.ID = obj.ID;
            
            this.Code = obj.Code;
            this.Gender = obj.Gender;
            this.ItemSubCategory = obj.ItemSubCategory;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.HSCodeBO> IQueryableToList(IQueryable<Indico.DAL.HSCode> oQuery)
        {
            List<Indico.DAL.HSCode> oList = oQuery.ToList();
            List<Indico.BusinessObjects.HSCodeBO> rList = new List<Indico.BusinessObjects.HSCodeBO>(oList.Count);
            foreach (Indico.DAL.HSCode o in oList)
            {
                Indico.BusinessObjects.HSCodeBO obj = new Indico.BusinessObjects.HSCodeBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.HSCodeBO> ToList(IEnumerable<Indico.DAL.HSCode> oQuery)
        {
            List<Indico.DAL.HSCode> oList = oQuery.ToList();
            List<Indico.BusinessObjects.HSCodeBO> rList = new List<Indico.BusinessObjects.HSCodeBO>(oList.Count);
            foreach (Indico.DAL.HSCode o in oList)
            {
                Indico.BusinessObjects.HSCodeBO obj = new Indico.BusinessObjects.HSCodeBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.HSCode> ToEntityList(List<HSCodeBO> bos, IndicoEntities context)
        {
            // build a List of HSCode entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.HSCode.Count() == 0) ? new List<Indico.DAL.HSCode>() : (context.HSCode.Where(BuildContainsExpression<HSCode, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.HSCode>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.HSCode> ToEntityCollection(List<HSCodeBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of HSCode entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.HSCode> el = (context.HSCode.Count() == 0) ? new List<Indico.DAL.HSCode>() : 
                context.HSCode.Where(BuildContainsExpression<HSCode, int>(e => e.ID, ids))
                .ToList<Indico.DAL.HSCode>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.HSCode> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.HSCode>();
                
            foreach (Indico.DAL.HSCode r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.HSCode ToEntity(IndicoEntities context)
        {
            return (from o in context.HSCode
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToHSCode(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.HSCode obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToHSCode(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.HSCode obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.HSCode obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.HSCodeBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.HSCodeBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.HSCode> oQuery =
                        from o in context.HSCode
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.HSCode> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.HSCodeBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.HSCode> oQuery =
                (from o in context.HSCode
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeBO> hscodes = IQueryableToList(oQuery);
            context.Dispose();
            return hscodes;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.HSCodeBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.HSCode> oQuery =
                (from o in context.HSCode
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.ItemSubCategory == 0 || this.ItemSubCategory == o.ItemSubCategory.ID) &&
                    (this.Gender == 0 || this.Gender == o.Gender.ID) &&
                    (this.Code == string.Empty || this.Code == o.Code) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeBO> hscodes = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return hscodes;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.HSCode
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.ItemSubCategory == 0 || this.ItemSubCategory == o.ItemSubCategory.ID) &&
                    (this.Gender == 0 || this.Gender == o.Gender.ID) &&
                    (this.Code == string.Empty || this.Code == o.Code) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.HSCode> oQuery =
                (from o in context.HSCode
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.ItemSubCategory == 0 || o.ItemSubCategory.ID == this.ItemSubCategory) &&
                    (this.Gender == 0 || o.Gender.ID == this.Gender) &&
                    (this.Code == string.Empty || o.Code.Contains(this.Code)) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeBO> hscodes = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return hscodes;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.HSCode
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.ItemSubCategory == 0 || o.ItemSubCategory.ID == this.ItemSubCategory) &&
                    (this.Gender == 0 || o.Gender.ID == this.Gender) &&
                    (this.Code == string.Empty || o.Code.Contains(this.Code)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.HSCode> oQuery =
                (from o in context.HSCode
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.ItemSubCategory == 0 || this.ItemSubCategory == o.ItemSubCategory.ID) && 
                    (this.Gender == 0 || this.Gender == o.Gender.ID) && 
                    ((o.Code.Contains(this.Code)) ||
                    (this.Code == null ))
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeBO> hscodes = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return hscodes;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.HSCode
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.ItemSubCategory == 0 || this.ItemSubCategory == o.ItemSubCategory.ID) && 
                    (this.Gender == 0 || this.Gender == o.Gender.ID) && 
                    ((o.Code.Contains(this.Code)) ||
                    (this.Code == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.HSCodeBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.HSCodeBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.HSCodeBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.HSCodeBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.HSCodeBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.HSCodeBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnHSCodeBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("HSCodeBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnHSCodeBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnHSCodeBOIDChanged();
        partial void OnHSCodeBOIDChanging(int value);
        
        partial void OnItemSubCategoryChanged()
        {
            OnHSCodeBOItemSubCategoryChanged();
        }
        
        partial void OnItemSubCategoryChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("HSCodeBO.ItemSubCategory must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnHSCodeBOItemSubCategoryChanging(value);
        }
        partial void OnItemSubCategoryChanged();
        partial void OnItemSubCategoryChanging(int value);
        partial void OnHSCodeBOItemSubCategoryChanged();
        partial void OnHSCodeBOItemSubCategoryChanging(int value);
        
        partial void OnGenderChanged()
        {
            OnHSCodeBOGenderChanged();
        }
        
        partial void OnGenderChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("HSCodeBO.Gender must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnHSCodeBOGenderChanging(value);
        }
        partial void OnGenderChanged();
        partial void OnGenderChanging(int value);
        partial void OnHSCodeBOGenderChanged();
        partial void OnHSCodeBOGenderChanging(int value);
        
        partial void OnCodeChanged()
        {
            OnHSCodeBOCodeChanged();
        }
        
        partial void OnCodeChanging(string value)
        {
            if (value != null && value.Length > 64)
            {
                throw new Exception(String.Format("HSCodeBO.Code has a maximum length of 64. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnHSCodeBOCodeChanging(value);
        }
        partial void OnCodeChanged();
        partial void OnCodeChanging(string value);
        partial void OnHSCodeBOCodeChanged();
        partial void OnHSCodeBOCodeChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.HSCodeBO))
                return 1;
            Indico.BusinessObjects.HSCodeBOComparer c = new Indico.BusinessObjects.HSCodeBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.HSCodeBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.HSCode)sender);
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region HSCodeBOComparer
    public class HSCodeBOComparer : IComparer<Indico.BusinessObjects.HSCodeBO>
    {
        private string propertyToCompareName;
        public HSCodeBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.HSCodeBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.HSCodeBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public HSCodeBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.HSCodeBO> Members
        public int Compare(Indico.BusinessObjects.HSCodeBO x, Indico.BusinessObjects.HSCodeBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.HSCodeBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.HSCodeBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.HSCodeBO x, Indico.BusinessObjects.HSCodeBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
