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
    public partial class EmailLogoBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private string _emailLogoPath;
        #endregion
        
        #region Foreign Key fields
        #endregion
        
        #region Foreign Table Foreign Key fields
        #endregion
        
        #region Other fields
        
        private Indico.DAL.EmailLogo _objDAL = null;
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
        
        /// <summary>The email logo path. The maximum length of this property is 256.</summary>
        public string EmailLogoPath
        {   
            get {return _emailLogoPath;}
            set 
            {
                OnEmailLogoPathChanging(value);
                _emailLogoPath = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.EmailLogoPath = value;
                }
                OnEmailLogoPathChanged();
            }
        }
        
        internal Indico.DAL.EmailLogo ObjDAL
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
        #endregion
        
        #region Foreign Object Foreign Key Collections
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the EmailLogoBO class using the supplied Indico.DAL.EmailLogo. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.EmailLogo whose properties will be used to initialise the EmailLogoBO</param>
        internal EmailLogoBO(Indico.DAL.EmailLogo obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.EmailLogo 
            this.ID = obj.ID;
            
            this.EmailLogoPath = obj.EmailLogoPath;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.EmailLogo SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.EmailLogo properties
            Indico.DAL.EmailLogo obj = new Indico.DAL.EmailLogo();
            
            if (this.ID > 0)
            {
                obj = context.EmailLogo.FirstOrDefault<EmailLogo>(o => o.ID == this.ID);
            }
            
            obj.EmailLogoPath = this.EmailLogoPath;
            
            
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.EmailLogo))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.EmailLogo obj = (Indico.DAL.EmailLogo)eObj;
            
            // set the Indico.BusinessObjects.EmailLogoBO properties
            this.ID = obj.ID;
            
            this.EmailLogoPath = obj.EmailLogoPath;
            
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.EmailLogoBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.EmailLogoBO properties
            this.ID = obj.ID;
            
            this.EmailLogoPath = obj.EmailLogoPath;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.EmailLogoBO> IQueryableToList(IQueryable<Indico.DAL.EmailLogo> oQuery)
        {
            List<Indico.DAL.EmailLogo> oList = oQuery.ToList();
            List<Indico.BusinessObjects.EmailLogoBO> rList = new List<Indico.BusinessObjects.EmailLogoBO>(oList.Count);
            foreach (Indico.DAL.EmailLogo o in oList)
            {
                Indico.BusinessObjects.EmailLogoBO obj = new Indico.BusinessObjects.EmailLogoBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.EmailLogoBO> ToList(IEnumerable<Indico.DAL.EmailLogo> oQuery)
        {
            List<Indico.DAL.EmailLogo> oList = oQuery.ToList();
            List<Indico.BusinessObjects.EmailLogoBO> rList = new List<Indico.BusinessObjects.EmailLogoBO>(oList.Count);
            foreach (Indico.DAL.EmailLogo o in oList)
            {
                Indico.BusinessObjects.EmailLogoBO obj = new Indico.BusinessObjects.EmailLogoBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.EmailLogo> ToEntityList(List<EmailLogoBO> bos, IndicoEntities context)
        {
            // build a List of EmailLogo entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.EmailLogo.Count() == 0) ? new List<Indico.DAL.EmailLogo>() : (context.EmailLogo.Where(BuildContainsExpression<EmailLogo, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.EmailLogo>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.EmailLogo> ToEntityCollection(List<EmailLogoBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of EmailLogo entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.EmailLogo> el = (context.EmailLogo.Count() == 0) ? new List<Indico.DAL.EmailLogo>() : 
                context.EmailLogo.Where(BuildContainsExpression<EmailLogo, int>(e => e.ID, ids))
                .ToList<Indico.DAL.EmailLogo>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.EmailLogo> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.EmailLogo>();
                
            foreach (Indico.DAL.EmailLogo r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.EmailLogo ToEntity(IndicoEntities context)
        {
            return (from o in context.EmailLogo
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
                this.Context.Context.AddToEmailLogo(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.EmailLogo obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToEmailLogo(obj);
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
                    Indico.DAL.EmailLogo obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.EmailLogo obj = this.SetDAL(objContext.Context);
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
            Indico.BusinessObjects.EmailLogoBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.EmailLogoBO; 
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
                    IQueryable<Indico.DAL.EmailLogo> oQuery =
                        from o in context.EmailLogo
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.EmailLogo> oList = oQuery.ToList();
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
        public List<Indico.BusinessObjects.EmailLogoBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.EmailLogo> oQuery =
                (from o in context.EmailLogo
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

            List<Indico.BusinessObjects.EmailLogoBO> emaillogos = IQueryableToList(oQuery);
            context.Dispose();
            return emaillogos;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.EmailLogoBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.EmailLogo> oQuery =
                (from o in context.EmailLogo
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.EmailLogoPath == null || this.EmailLogoPath == o.EmailLogoPath) 
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

            List<Indico.BusinessObjects.EmailLogoBO> emaillogos = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return emaillogos;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.EmailLogo
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.EmailLogoPath == null || this.EmailLogoPath == o.EmailLogoPath) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.EmailLogo> oQuery =
                (from o in context.EmailLogo
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.EmailLogoPath == null || o.EmailLogoPath.Contains(this.EmailLogoPath)) 
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

            List<Indico.BusinessObjects.EmailLogoBO> emaillogos = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return emaillogos;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.EmailLogo
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.EmailLogoPath == null || o.EmailLogoPath.Contains(this.EmailLogoPath)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.EmailLogoBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.EmailLogo> oQuery =
                (from o in context.EmailLogo
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.EmailLogoPath.Contains(this.EmailLogoPath)) ||
                    (this.EmailLogoPath == null ))
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

            List<Indico.BusinessObjects.EmailLogoBO> emaillogos = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return emaillogos;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.EmailLogo
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.EmailLogoPath.Contains(this.EmailLogoPath)) ||
                    (this.EmailLogoPath == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.EmailLogoBO to an XML representation
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
        /// Deserializes Indico.BusinessObjects.EmailLogoBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.EmailLogoBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.EmailLogoBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.EmailLogoBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.EmailLogoBO object in an XmlElement
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
            OnEmailLogoBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("EmailLogoBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnEmailLogoBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnEmailLogoBOIDChanged();
        partial void OnEmailLogoBOIDChanging(int value);
        
        partial void OnEmailLogoPathChanged()
        {
            OnEmailLogoBOEmailLogoPathChanged();
        }
        
        partial void OnEmailLogoPathChanging(string value)
        {
            if (value != null && value.Length > 256)
            {
                throw new Exception(String.Format("EmailLogoBO.EmailLogoPath has a maximum length of 256. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnEmailLogoBOEmailLogoPathChanging(value);
        }
        partial void OnEmailLogoPathChanged();
        partial void OnEmailLogoPathChanging(string value);
        partial void OnEmailLogoBOEmailLogoPathChanged();
        partial void OnEmailLogoBOEmailLogoPathChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.EmailLogoBO))
                return 1;
            Indico.BusinessObjects.EmailLogoBOComparer c = new Indico.BusinessObjects.EmailLogoBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.EmailLogoBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.EmailLogo)sender);
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
    
    #region EmailLogoBOComparer
    public class EmailLogoBOComparer : IComparer<Indico.BusinessObjects.EmailLogoBO>
    {
        private string propertyToCompareName;
        public EmailLogoBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.EmailLogoBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.EmailLogoBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public EmailLogoBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.EmailLogoBO> Members
        public int Compare(Indico.BusinessObjects.EmailLogoBO x, Indico.BusinessObjects.EmailLogoBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.EmailLogoBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.EmailLogoBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.EmailLogoBO x, Indico.BusinessObjects.EmailLogoBO y)
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
